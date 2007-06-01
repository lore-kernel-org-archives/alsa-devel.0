From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: 1.0.14 test packages
Date: Fri, 01 Jun 2007 08:53:32 +0200
Message-ID: <1180680812.27046.1192869623@webmail.messagingengine.com>
References: <Pine.LNX.4.61.0705311058180.15545@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2666B244BA
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 08:53:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0705311058180.15545@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> ftp://ftp.alsa-project.org/pub/testing

Some platform_* wrappers for 2.4.x are missing:

depmod: *** Unresolved symbols in /lib/modules/2.4.31/kernel/sound/drivers/snd-portman2x4.o
depmod:         platform_device_alloc
depmod:         platform_device_put
depmod:         platform_device_add
