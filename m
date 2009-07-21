From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Two Codecs in the machine driver
Date: Mon, 20 Jul 2009 20:28:46 -0500
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE4891B081@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BCD04243EF
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 03:28:54 +0200 (CEST)
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n6L1Skj0011664
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2009 20:28:51 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n6L1SjWF003917
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2009 20:28:45 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n6L1SjMA000603
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2009 20:28:45 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all, 

I have a hardware platform which has two codecs and I want to create a SoC machine driver to connect them to the processor, but it's not clear to me how to do that. Do you have any suggestions? Is there any driver that I can see as an example?

Thanks & Regards,
Margarita
