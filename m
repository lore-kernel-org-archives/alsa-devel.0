From: "Jared D. McNeill" <jared.mcneill@gmail.com>
Subject: Re: intel8x0m and conexant ac97 modem codecs
Date: Tue, 12 Apr 2005 15:22:19 -0300
Message-ID: <41d6f0b9050412112249f3d1f7@mail.gmail.com>
References: <41d6f0b90504120905d469db0@mail.gmail.com>
	 <425C10C1.3020202@pobox.sk>
Reply-To: "Jared D. McNeill" <jared.mcneill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <425C10C1.3020202@pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net, jmcneill@netbsd.org
List-Id: alsa-devel@alsa-project.org

On Apr 12, 2005 3:17 PM, Peter Zubaj <pzad@pobox.sk> wrote:
> Last time I google for this I found, that no one knows how to setup
> analog part of modem - no docs.

Interesting -- figures that the only hardware that I can actually test
myself would be broken.

> One not technical reason - licence of slmodem package forbit use of
> their drivers with modem not made by them - then there is no modem
> software to use alsa modem driver.

The slmodem sources that I've been working with (slmodem-2.9.9b) don't
mention this restriction. The COPYING file in 2.9.9b appears to be a
standard BSD license; the COPYING file in 2.9.10 mentions this
restriction though.

Cheers,
Jared


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
