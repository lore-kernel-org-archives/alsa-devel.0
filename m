From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [Fwd: Re: newer C-Media CMI9761A, unrequested headphone-out,
 equalizer set, [CLOSED]
Date: Fri, 18 Feb 2005 21:43:09 +0100
Message-ID: <4216535D.1060302@gmx.de>
References: <42162C3C.6000703@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <42162C3C.6000703@gmx.de>
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

thomas schorpp wrote:
> hello,
> 
> tonight i discovered one more issue:
> 
> sound output quality of the looped through lines conn. to external
> hifi-amplifier:
> 
> - low+high band drain > 6dB or mid-band gain > 6dB
> 
> possible causes:
> 
> - driver sets headphone output instead of external ampflifier mode
> (poss. wrong output impedance effecting fr-linearity)
> 
> tried switching in mixer, result negative.
> 
> - the build-in equalizer is set implicitely online by the driver.
> 
> y
> tom

closed.

no more reproducible.

tom




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
