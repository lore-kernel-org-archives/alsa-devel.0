From: Marius Cirsta <mforce2@gmail.com>
Subject: X-Fi XtremeGamer front header ( headphones ) audio
Date: Mon, 22 Dec 2014 16:33:12 +0200
Message-ID: <CANO0Vk4DpYa+5snRa-qaqbxBBPDQ_CY_4e-LpyCgDAnX5GkkXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AFC62606EC
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 15:33:13 +0100 (CET)
Received: by mail-vc0-f176.google.com with SMTP id hq12so1688069vcb.35
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 06:33:12 -0800 (PST)
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

I've got a X-Fi XtremeGamer ( SB0770 ) and I can't get sound output
from the headphone plug in my case which is plugged into the front
panel connector on the SB0770.

 This does work in Windows so I'm assuming that it's unimplemented in
ALSO for the X-Fi. I can see no mention of headphones in the alsamixer
either.

 Also looking at the code I can see nothing regarding the headphones
part of this. If the implementation is indeed missing how difficult
would it be to implement this ? I'd like try.
