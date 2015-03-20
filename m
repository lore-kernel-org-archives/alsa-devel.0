From: "C. Omer Rafique" <omer.job@gmail.com>
Subject: ASoC: Max98090 Codec DAPM Widget setup in Open Embedded
Date: Fri, 20 Mar 2015 15:25:57 -0700
Message-ID: <CANNxnyCNCy97L9Q+xmj6Jk_f1thKkq9zv4A1FQOaWsgZWRcfqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f42.google.com (mail-yh0-f42.google.com
 [209.85.213.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E8702650DB
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 23:26:03 +0100 (CET)
Received: by yhjf44 with SMTP id f44so46148666yhj.3
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 15:25:59 -0700 (PDT)
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

I would like to know which file I can use to connect/enable
DPAM widgets permanently so a simple aplay/record can work?

My environment is:
- Yocto Linux Kernel 3.10 - (DTS based)
- Max98090 Codec
- imx6SL SoC

I thought about doing this in alsa.conf or asound.conf but I couldn't
find a single example with DAPM widgets .

Thank you

Choudhary
