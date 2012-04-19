From: "Patrick" <patrick.pub@nerim.net>
Subject: Steinberg CMC
Date: Thu, 19 Apr 2012 15:15:48 +0200
Message-ID: <3DADBEB76B314C5EAC8F789321D691E7@nanhstxbtkmyli>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mallaury.nerim.net (smtp-104-thursday.noc.nerim.net
	[178.132.17.104])
	by alsa0.perex.cz (Postfix) with ESMTP id 70466245EC
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 15:15:51 +0200 (CEST)
Received: from nanhstxbtkmyli (patrickpouget.net1.nerim.net [62.212.102.248])
	by mallaury.nerim.net (Postfix) with ESMTP id 6EF62153448
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 15:15:45 +0200 (CEST)
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

Hi

I own 3 of the 6 Steinberg control surfaces CMC series

To run them, I added some entries in the (usb) quirk-table.

They are midi input and output of vendor ID Yahama and products as the
following
CMC-CH 0x1060
CMC-TP 0x1061
CMC-AI 0x1065

Where to notify that or how to add a patch? For the patch, should I paste
the lines in the last Linux Kernel version and create the patch?

Cheers

Patrick
