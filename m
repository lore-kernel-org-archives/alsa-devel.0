From: Mark Constable <markc@renta.net>
Subject: Re: guitar + sblive + ardour + ladspa effects
Date: Tue, 30 Jul 2002 16:40:16 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <30007.2191552774$1028011251@news.gmane.org>
References: <1027973318.10978.62.camel@insanity>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1027973318.10978.62.camel@insanity>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bob Ham wrote:
> > name='Line LiveDrive Capture Volume',index=1
> > name='Line LiveDrive Capture Volume',index=1
> >
> > This control is used to attenuate samples from left and right I2S ADC
> > inputs (on the LiveDrive). The result samples are forwarded to the ADC
> > capture FIFO (thus to the standard capture PCM device).
>
> What's the ADC capture FIFO?  What's the standard capture PCM device?
> What have these to do with recording from hw:0,0?  Why is it that ardour
> only seems to be able to hear the line input when I put up the volume on
> "Line LiveDrive" and not "Line LiveDrive Capture"?  What is the
> "Capture" device sitting in alsamixer?  What difference does the little
> red "Capture" make above the sliders in alsamixer?

I wish I knew the answers to your questions. This is just to let folks
know there has been a page ready for some time to help with these controls
but it needs a bit of input... 

 http://alsa.opensrc.org/?SBliveMixerControls

It's now linked to from http://alsa.opensrc.org/?emu10k1

--markc


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
