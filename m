From: Martin Langer <martin-langer@gmx.de>
Subject: Re: ALSA 1.0.6rc2
Date: Tue, 10 Aug 2004 00:30:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040809223044.GA517@tuba.home>
References: <Pine.LNX.4.58.0408071354310.1780@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id DE1B6234
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2004 00:29:03 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408071354310.1780@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 07, 2004 at 01:57:59PM +0200, Jaroslav Kysela wrote:
> 
> 	It might be the last release candidate for 1.0.6.

I've just noticed on 2.6.7/ppc:

/usr/local/src/alsa-driver-1.0.6rc2/pci/hdspm.c: In function
snd_hdspm_hwdep_ioctl':
/usr/local/src/alsa-driver-1.0.6rc2/pci/hdspm.c:3288: error: case label does
not reduce to an integer constant


martin


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
