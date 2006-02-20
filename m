From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Mon, 20 Feb 2006 10:57:03 +1030 (CST)
Message-ID: <200602200027.k1K0R3Q3022176@auster.physics.adelaide.edu.au>
References: <43F5BC71.6040404@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F5BC71.6040404@akl.lt> from "Rimas Kudelis" at Feb 17, 2006 02:07:13 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Very interesting.  The only difference between the "line out" and "headphone"
> > setting is that the latter enables an onboard amplifier which allows it
> > to drive headphones to a louder volume.  On the headphones I've tried 
> > you still get adequate output when the pin is "lineout" - it's just slightly
> > louder when "headphone" mode is selected.
> 
> OK, then I hope it doesn't apply here, as I'm testing things with an 
> external amplifier connected to big speakers.

If this is how you're testing then I would expect there to be very little
difference in the audio through the speakers when the "lineout" and
"headphone" mode settings are used.

> >> Btw, when I redirect the output to Line In, and make everything else
> >> (HP-OUT, LINE-OUT, LINE2 and MIC2) be "Headphone" pins, I get a lot of
> >> noise from the speakers connected to the Line In jack. These seem to catch
> >> some interference even from the video card (just noticed). That electronic
> >> noise differs depending on what I see in the screen atm. Weird...
> > 
> > Which output - the headphone jack?  What kind of noise - squeals or hiss?
> 
> Hard to tell (English is not my native), but I think it's more like 
> hiss. Actually, it sounds a bit similar to a TV with bad reception, 
> except that in my case the noise is quiet enough.

Ok, that would be "hiss".

> >   2) Does the laptop have an external volume control?  If so, is it turned
> >      up to maximum?
> 
> No, it doesn't. Just the keyboard controls that Paolo has mentioned.

Right.  It was worth checking.

> BTW, could I catch you on IRC or MSN or some other real-time media?

Not at this stage.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
