From: "Geiger Ho" <geiger.ho@fmp.fujitsu.com>
Subject: building soc module drivers
Date: Wed, 25 Mar 2009 12:26:36 +0800
Message-ID: <49C9B27C.8040108@fmp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.fmp.fujitsu.com (pcd753105.netvigator.com [218.103.29.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 50A881037FD
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 05:26:55 +0100 (CET)
Received: from mail.fmp.fujitsu.com (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id
	A4DA02220217_9C9B29AB
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 04:27:06 +0000 (GMT)
Received: from fmalhkmsex03.fmal.fujitsu.com (unknown [172.16.56.143])
	by mail.fmp.fujitsu.com (Sophos Email Appliance) with ESMTP id
	9E9F2222017C_9C9B290F
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 04:26:56 +0000 (GMT)
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

Hi all,

  I would like to build the WM8510 SOC sound driver for my ARM platform. 
After downloading alsa-driver-1.0.19, "./configure 
--with-cross=arm-linux- --with-kernel=/home/source/linux-2.6.22.19 
--with-build=/home/source/linux-2.6.22.19 --with-cards=all", and then 
make. I get no wm8510.c compiled. What other stuff should I do to make 
it compiled? Many thanks.

Best regards,
Geiger

-- 
Geiger Ho  <geiger.ho@fmp.fujitsu.com>, armed with Agile and Lean.
Mission: To deliver quality of work.
Phone : (852) 2736-3232 Direct : (852) 2737-9681   Fax : (852) 2314-4207
Fujitsu Microelectronics Pacific Asia Ltd, Design Centre
