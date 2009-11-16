From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] fix softfloat handling
Date: Mon, 16 Nov 2009 11:14:53 +0100
Message-ID: <1258366495-10815-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B2F68244D1
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:15:00 +0100 (CET)
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <mkl@pengutronix.de>) id 1N9ybs-0006xL-EL
	for alsa-devel@alsa-project.org; Mon, 16 Nov 2009 11:15:00 +0100
Received: from mkl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <mkl@pengutronix.de>) id 1N9ybs-0003RY-DP
	for alsa-devel@alsa-project.org; Mon, 16 Nov 2009 11:15:00 +0100
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

Hello,

this series of two patches fixes the softfloat handling within the alsa-lib.
Please review and consider to apply.

cheers, Marc
