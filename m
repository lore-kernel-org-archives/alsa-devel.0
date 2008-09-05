From: dinesh <dinesh.dua@coraltele.com>
Subject: ALSA SOC VI API's for 2 PCM DEVICE ON SAME CARD
Date: Fri, 05 Sep 2008 12:18:57 +0530
Message-ID: <1220597338.25078.15.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 89CF9103808
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 08:49:12 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.coraltele.com (Postfix) with ESMTP id 43EF21B2822
	for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2008 12:19:07 +0530 (IST)
Received: from mail.coraltele.com ([127.0.0.1])
	by localhost (mail.coraltele.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csK3gR52iaEg for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 12:19:01 +0530 (IST)
Received: from [192.168.4.53] (unknown [192.168.4.53])
	by mail.coraltele.com (Postfix) with ESMTPA id 49DA31B2806
	for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2008 12:19:01 +0530 (IST)
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

Hi,

Actually i am stuck with a problem i have two register 2 channels of my
SOC device as 2 different pcm devices on same card.
But my driver uses ALSA V1 api's and i am not able to find out any
example code for this using v1 api's.    (SIMILAR TO MPC5200_PSC.C)

If anyone can help me please.

Thanks,
Dinesh
