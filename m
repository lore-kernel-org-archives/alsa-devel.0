From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: timepiece alsa drivers
Date: 10 Mar 2002 20:12:03 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1015751525.2205.5.camel@littlewolf1.littlewolf>
References: <20020227071202.35411.qmail@web9103.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020227071202.35411.qmail@web9103.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "Jan P." <jipekau@yahoo.com>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

HI ...sorry about hte delayed response... 


Just a quick response.. at present I have figured out my parrallel port
or the BIOS on my motherboard is not acting very well (Atrend
ATC-5200..VIA MVP-3 chipset) .. Sysex dumps under Win98 don't work...
yet they do on my old laptop (not running Linux) .. SO I haven't got
multichannel MIDI working under Linux .. as a result of not being 100%
sure of my hardware I haven't contributed to the ALSA-Dev mailing list
on this issue for sometime. 

I will be upgradig in the coming months .. and will return to try anuse
the MTP-AV with ALSA>... 

However the timing accuracy tests I performed with Takashi worked fine
and there isn't a problem with MIDI timing if you install the low
latency patches (and the sequencer uses them) ... 



Hope it all goes well

Allan  




On Wed, 2002-02-27 at 18:12, Jan P. wrote:
> > > Takashi-
> > > 
> > > Thanks for the response. Can you put me in touch
> > with
> > > anyone that is using the Timepiece under ALSA? or
> > is
> > > there another multichannel MIDI box that is better
> > > supported?
> > 
> > It'd be better to ask this on alsa-devel ML.
> > some people must have the hardware.
> > I know Allan Klinbail <allank@labyrinth.net.au> has
> > one and he helped
> > me to debug the stuff ago.
> 
> Hi Allan-
> 
> Takashi suggested I talk to you. I'm looking at the
> MOTU Timepiece for multichannel MIDI-controlled
> effects under Linux. I'm concerned about latency
> coming from parallel port and the stability of the
> driver. Can you speak to either of these?
> 
> Thanks,
> Jan
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Greetings - Send FREE e-cards for every occasion!
> http://greetings.yahoo.com



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
