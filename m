From: Simon <evereve@email.it>
Subject: Add "cval->res = 384" quirk for Logitech Webcam C500
Date: Mon, 03 Mar 2014 19:12:38 +0100
Message-ID: <5314C616.101@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm17-vm8.bullet.mail.ir2.yahoo.com
 (nm17-vm8.bullet.mail.ir2.yahoo.com [212.82.96.223])
 by alsa0.perex.cz (Postfix) with ESMTP id D894A2656A1
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 19:12:39 +0100 (CET)
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

Hello,

Since some time I am successfully using this workaround

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-March/037657.html

to solve the problem for the Logitech C500 Webcam (046d:0807).
Would it be possible to add this device to the list included in the 
mixer.c file?

Thanks
