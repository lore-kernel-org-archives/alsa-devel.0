From: Richard Olsson <flame@home.se>
Subject: Re: CS46xx woes.
Date: Sat, 16 Nov 2002 20:33:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021116203320.5828f7dd.flame@home.se>
References: <20021115121043.67b5c0af.flame@home.se>
	<Pine.LNX.4.33L2.0211151339210.14712-100000@cactus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33L2.0211151339210.14712-100000@cactus>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Considerating the Hercules Gametheater XP breakout box as a cheap
> construction the soundquality you will get from the analog output,
> speakers, headphones, etc. will never be very good. (But using the
> SPDIF output to an external receiver works great, at least forme -:) )

Heh; I haven't noticed anything bad with it while using Windows, but
then again I don't set so high standards. ;)

> About you sound-experience, sounds like there some trouble with
> the soundcard amplifier, you would experience this kind of trouble
> if it for some reason have been turned of (which in theory should
> not happen with rc5 or latest CVS)
> Actually there was a hack related to the CD-input, which turned
> of the amplifier when CD-line input was unmuted. Could you
> try with rc2 and latest CVS to unmute CD-input and test
> you hear any diference, if you can disconnect the CD-input cable
> physically from the soundcard, and see if you hear any diference ?

Hmm; with rc2 if I unmute the cd input the amplifier seems to get
disabled sometimes (thus resulting in very badly disorted sound), but
using latest CVS nothing happens.

-- 
Richard Olsson
home: flame@home.se
WWW: http://www.nyo-box.net/


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
