From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS vs ALSA war :-)
Date: Tue, 10 Aug 2004 13:21:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1092158472.3290.12.camel@mindpipe>
References: <200408101716.SAA04883@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 3135A1F0
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2004 19:20:54 +0200 (MEST)
In-Reply-To: <200408101716.SAA04883@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: William <walsac3@liam2.demon.co.uk>
Cc: geeceezee@free.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-08-10 at 13:16, William wrote:
> Lee Revell wrote:
> > GCZ wrote:
> >> Should I refrain from playing UT2004 just because Nvidia's drivers,
> >> which work beautifully, are closed-source? Should I refrain from
> >> playing Quake 3 because ALSA doesn't work with it?
> > 
> > No, this is why ALSA provides OSS emulation, so every legacy app doesn't
> > have to be recoded.
> 
> One big problem is that some parts of ALSA's OSS emulation have been buggy
> for a long time, especially its /dev/sequencer emulation:
> https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=28
> [First reported August 2002, present since before Alsa 0.9.0]
> 

Heh, the ALSA bug tracker is hosed right now.  It didn't seem to
remember my login, then when I went to sign up for a new account I got:

ALSA bugtracking system
Warning: Cannot modify header information - headers already sent by
(output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in
/srv/www/mantisbt-0.18.3/core/gpc_api.php on line 220

Warning: Cannot modify header information - headers already sent by
(output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in
/srv/www/mantisbt-0.18.3/core/print_api.php on line 37

Warning: Cannot modify header information - headers already sent by
(output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in
/srv/www/mantisbt-0.18.3/core/print_api.php on line 39

Warning: Cannot modify header information - headers already sent by
(output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in
/srv/www/mantisbt-0.18.3/core/print_api.php on line 44

If you can access the text of that bug can you send it to me?

Lee




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
