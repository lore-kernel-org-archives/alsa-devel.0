From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [ALSA - driver 0000186]: rear, iec958, and center
 lfe missing
Date: Thu, 15 Jul 2004 14:02:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040715140206.7bfd2d38@mango.fruits.de>
References: <9c47e2970ac966845ed0962a6a949306@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id D72271EE
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2004 13:54:14 +0200 (MEST)
In-Reply-To: <9c47e2970ac966845ed0962a6a949306@bugtrack.alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jul 2004 02:05:22 +0200
noreply@alsa-project.org wrote:

> did you enabled CONFIG_CS46XX_NEW_DSP kenrel config?
> it needs also CONFIG_EXPERIMENTAL.

Hi, i just wanted to chime in with a question here: how does one select the new dsp code when compiling from the tarball directly? ./configure --with-cards=cs46xx seems to select to old dsp code [non hw mixing]. tried with 1.0.5a..

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/wiki



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
