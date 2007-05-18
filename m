From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: alsa-driver 1.0.14rc4 compile
	error	resolved	(was:	Linux 2.6.21 regression
	with	hda-intel	(Conexant	5045))
Date: Fri, 18 May 2007 17:40:41 +0200
Message-ID: <f2khd1$p1p$1@sea.gmane.org>
References: <f2h9a9$d15$1@sea.gmane.org>
	<1179414132.4415.295.camel@razman.gruemaster.com>
	<f2jq7l$5ru$1@sea.gmane.org> <s5hveeqeba4.wl%tiwai@suse.de>
	<f2js0l$at0$1@sea.gmane.org> <s5hps4yea9x.wl%tiwai@suse.de>
	<f2k04f$oq1$1@sea.gmane.org> <s5hd50ye3zr.wl%tiwai@suse.de>
	<f2kaen$u4n$1@sea.gmane.org> <s5hps4ymd39.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id F191624392
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 17:40:56 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hp4ZO-0001xO-Ji
	for alsa-devel@alsa-project.org; Fri, 18 May 2007 17:40:43 +0200
Received: from bras-co-85-197-6-232.westend.de ([85.197.6.232])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 17:40:42 +0200
Received: from G.Ohrner by bras-co-85-197-6-232.westend.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 17:40:42 +0200
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

Takashi Iwai wrote:
> Thanks.  Could you try the patch below?

After applying the patch and running autoconf manually, it's currently
compiling - thus, it seems to work. :-)

Greetings,

  Gunter
