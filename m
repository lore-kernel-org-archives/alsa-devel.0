From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: Linux 2.6.21 regression with hda-intel
	(Conexant	5045)
Date: Fri, 18 May 2007 12:11:04 +0200
Message-ID: <f2ju31$gat$2@sea.gmane.org>
References: <f2h9a9$d15$1@sea.gmane.org>
	<1179414132.4415.295.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 10CE324532
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 12:10:59 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HozQB-0000c5-57
	for alsa-devel@alsa-project.org; Fri, 18 May 2007 12:10:51 +0200
Received: from bras-co-85-197-6-232.westend.de ([85.197.6.232])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 12:10:51 +0200
Received: from G.Ohrner by bras-co-85-197-6-232.westend.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 12:10:51 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin Davis wrote:
> what kernels.  The best thing to do is download the
> alsa-driver-1.0.14rc4.tar.bz2 release from alsa-project.org and use it.
> It is the most current for that codec.

Seems to work fine so far.

Looks as if Linux 2.6.21 contains a broken driver which has subsequently
been fixed.

Thanks a lot!

Greetings,

  Gunter
