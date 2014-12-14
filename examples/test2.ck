4=>int NUM;

MageCK mageck[NUM];
[48,50,52,53,55,56,58,59] @=> int scale[];


Pan2 pan[NUM];
JCRev rev=>dac;
int i;
for(0=>i;i<NUM;i++)
{

	mageck[i].init("awb","data/configFiles/cmu-artic/awb.conf","data/labels/cmu-artic/alice01.lab",0.55);
	mageck[i]=>pan[i]=>rev;	
}
0.3=>rev.mix;

int p,q,r;

110=>float f0;

fun void controldur()
{
	while(true)
	{
		Math.random2(1,4)=>int temp;
		int i;
		for(0=>i;i<NUM;i++)
			temp*2.0 => mageck[i].framebeat;
		temp*2.0::ms=>now;
	}
}

spork ~controldur();

section2();
fun void section2()
{
	
	for(0=>i;i<NUM;i++)
	{	
		0=>mageck[i].gain;
	}

	100=>f0;
	0=>p;
	1=>q;

	for(0=>i;i<NUM;i++)
	{
		p+q=>r;
		q=>p;
		r=>q;


		r*f0=>mageck[i].freq;
		spork ~addComponent(1.0/NUM,i);
		-1.0+2.0/NUM*i=>pan[i].pan;
		<<<pan[i].pan()>>>;

	}
	40::second=>now;
	
}


fun void addComponent(float gain,int i)
{
	now=> time mark;

	mageck[i].startSynthesis();

	while(now<mark+1::second)
	{
		mageck[i].gain()+gain/1000.0 => mageck[i].gain;
		1::ms=>now;
	}
	
}

/*
while(true)
{
	j=>i;
	k=>j;
	(i+j)%8=>k;
	scale[k] +Math.random2(-1,1)*12 => Std.mtof => mageck.freq;
	
	
	100::ms=>now;	
}


fun void control()
{
	while(true)
	{
		mageck.startSynthesis();
		1::second=>now;
		mageck.stopSynthesis();
	}
}

fun void dur()
{
	1::second=>now;
	0=>int i;
	while(true)
	{

	//	<<<i,"th turn">>>;
		//<<<mageck.ready()>>>;
		if(mageck.ready()==1)
		{	
			if(mageck.popLabel()==1)
			{
				//<<<"popLAbel">>>;
		//		<<<mageck.computeDuration()>>>;
			 	mageck.computeDuration();
			 	50::ms=>now;
			}
			else
			{
				<<<"pop failed">>>;
			}
		}
		else 
		{
			1000::ms=>now;	
		}
		
		//i++;
	}
}

fun void compute()
{
	while(true)
	{
		mageck.computeParameters();
		e=>now;
	}
}
*/


