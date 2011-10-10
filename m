From: William Light <alsa-dev@wrl.illest.net>
Subject: [PATCH 0/2] snd-usb-caiaq: Initial Work on NI Maschine
	Support
Date: Mon, 10 Oct 2011 15:54:21 +0000
Message-ID: <1318262063-19247-1-git-send-email-alsa-dev@wrl.illest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dudestache.don.gs (don.gs [208.79.89.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C66D245C3
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 17:54:52 +0200 (CEST)
Received: from localhost (1002@localhost [IPv6:::1])
	by dudestache.don.gs (OpenSMTPD) with ESMTP id
	1318262068.Y5onIibxlwhduBgY
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 15:54:28 +0000 (UTC)
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

These patches extend the existing snd-usb-caiaq driver to support the Native
Instruments Maschine controller (http://native-instruments.com/maschine).
Future work will be on adding support for the LEDs and the two greyscale
screens.

Thanks,
Will
