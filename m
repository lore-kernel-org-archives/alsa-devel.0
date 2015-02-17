From: Xuebing Wang <xbing6@gmail.com>
Subject: iMX6 SSI driver: fsl_ssi vs imx-ssi
Date: Tue, 17 Feb 2015 08:09:42 +0800
Message-ID: <54E286C6.8030705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 5585D2606D6
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 01:09:48 +0100 (CET)
Received: by mail-qc0-f175.google.com with SMTP id b13so20690031qcw.6
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 16:09:47 -0800 (PST)
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi community,

I am developing an ASOC codec driver based on iMX6SL platform. I noticed 
there are fsl_ssi.c and imx-ssi.c in folder sound/soc/fsl.

Would you please tell me what are the differences between these 2, and 
which one should I use? Thanks.

-- 
Xuebing
