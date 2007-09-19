From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: Realtek ALC660-VD jack sense
Date: Wed, 19 Sep 2007 07:05:07 +0000 (UTC)
Message-ID: <loom.20070919T090202-902@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id BC25624447
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 09:05:32 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXtci-0007CR-Lk
	for alsa-devel@alsa-project.org; Wed, 19 Sep 2007 09:05:24 +0200
Received: from 207-2-207-82.pool.ukrtel.net ([82.207.2.207])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2007 09:05:24 +0200
Received: from farcaller by 207-2-207-82.pool.ukrtel.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2007 09:05:24 +0200
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

Hello all,

I wonder if it could be possible to somehow fix jack sense detection on Realtek
ALC660-VD and speaker output. When I plug in headphones speakers are still
working and there's no way to separately mute them.
