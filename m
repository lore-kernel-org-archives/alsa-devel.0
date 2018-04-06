From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Procedure for alsa modules compilation from git
Date: Fri, 6 Apr 2018 20:07:47 +0200
Message-ID: <c5de487e-3d99-e7d9-7640-cf1781748075@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id BECCB266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 20:08:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 60BD1A00F0905
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 20:08:00 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cN70ca1y3dgw for <alsa-devel@alsa-project.org>;
 Fri,  6 Apr 2018 20:07:55 +0200 (CEST)
Received: from [192.168.105.119] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 34768A00F0737
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 20:07:55 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

May I ask for description/link describing current working compilation of 
alsa modules from git? I would like to compile only alsa modules, 
against my stock ubuntu kernel. Headers/sources in /usr/src, configured 
to current configuration from /boot/config...

What is the oldest kernel to compile against (isch)? Would 4.4 work?

I would like to make a small patch for ice1724, test, and send here for 
review/inclusion.

I very much appreciate any help. I think it would be useful to many 
other occasional devels.

Thanks a lot,

Pavel.
