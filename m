From: Jon Smirl <jonsmirl@gmail.com>
Subject: Call out after period buffer is filled
Date: Tue, 5 May 2009 10:35:17 -0400
Message-ID: <9e4733910905050735g168d2c4ibf1ce91538557513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 56C251037FA
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 16:35:19 +0200 (CEST)
Received: by fxm18 with SMTP id 18so5192839fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 05 May 2009 07:35:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Is there some way to get a call out after a period DMA buffer is
filled so that I can add it to the DMA queue?

-- 
Jon Smirl
jonsmirl@gmail.com
