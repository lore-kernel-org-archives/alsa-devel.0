From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Phase Reversal on Santa Cruz (cs46xx)
Date: Sun, 17 Nov 2002 16:52:05 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211171652.05776.puetzk@iastate.edu>
References: <200211170056.11190.puetzk@iastate.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211170056.11190.puetzk@iastate.edu>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sunday 17 November 2002 00:56, you wrote:
> I am not currently a subscriber to this list, so pease CC me on any
> responses.

OK,  I decided to subscribe, so I ignore this.

> Frank, Benny, the guess of a phase reversal as responsible for the 'lack of
> bass' on this card is dead-on - a little tinkering with artsbuilder (had to
> remember how to do it) to place an inverter in one channel of the output
> path brings sound back to perfection. Great guess!
>
> I can pretty much leave the sub (which has one cone and mixes the channels
> first) silent against a full-volume sine wave, or invert it and have it
> perfect. I can definitely hear sine waves at higher frequencies attenuated
> to some extent if I move the speakers directly adjacent to one another. I'd
> say that confirms it pretty well.

I have also got an aRts stereo effect to fix it for noatun now, so I can 
verify it fixing the sound for general music as well. Yippie :-)

> So... anything that can be done to fix this (I assume so, since it's a new
> problem since older alsa), or do I have to cut my speaker wires apart? :-P

Still hopfully alsa gets fixed and I can throw away the effect plugin :-)


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
