From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch v3 0/2] ASoC: alc562[123] / HP t5325 support -
	try 3
Date: Thu, 21 Oct 2010 12:44:36 +0200
Message-ID: <20101021104436.725702942@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id BFA0924413
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 12:50:09 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org



Hi,

It's an other try to get alc562[123] and HP t5325 support merged into ASoC tree.
There was not a lot of changes except on places where I got comments (except on
the depop stuff). I've also removed the patch on 
arch/arm/mach-kirkwood/t5325-setup.c which will go through an other route later.


Arnaud
