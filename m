From: Koby Andersen <koby@razordata.com>
Subject: snd-intel8x0
Date: Wed, 09 Mar 2005 18:36:34 -0700
Message-ID: <1110418594.5334.7.camel@209.90.108.253.airwired.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am having trouble with all recent versions of ALSA (currently running
1.0.6, but have run all the way up to 1.0.8 with more recent kernels as
well) and my SIS7012 sound card with the SIS 735 (technically its a SIS
650 in a PC Club laptop).

My sound card works properly so long as no headphones are attached.  As
soon as I plug in headphones all sound is muted to both the speakers and
the headphones.  

In the alsamixer I have no option at all for headphones so I imagine
that is the problem.  ALSA has no idea that I have a headphone jack;
when the headphones are plugged in this triggers the hardware muting and
I have no way to un-mute the headphones.  

If you want any additional information just tell me what you want and I
will do my best to get it to you in a timely fashion.









-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
