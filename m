From: Aishwarya M <aishdhan986@gmail.com>
Subject: Regarding alsa snd_pcm_rewind()
Date: Thu, 8 Aug 2019 15:33:09 +0530
Message-ID: <CAGKLxt+7MmrkUBf6Y9ugb7JZY5h9FcmzQJsv8AwEBswOFPaP0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4397DF803F3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 12:03:22 +0200 (CEST)
Received: by mail-ot1-x334.google.com with SMTP id q20so116145658otl.0
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2019 03:03:22 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Greetings,

I am currently working on an AudioPlayer which can play, pause, seek
forward, seek backward the audio using ALSA. For seek forward and backward
i would like to know if we can employ alsa's snd_pcm_rewind() and
snd_pcm_forward() ? Please could you explain how exactly i can use it for
my AudioPlayer application.

Looking forward to hearing from you.

Thank you.

Aishwarya M
aishdhan986@gmail.com
