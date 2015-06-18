From: Happy <happy.musicmaker@gmail.com>
Subject: How to build alsa-driver ?
Date: Thu, 18 Jun 2015 22:04:02 +0800
Message-ID: <1434636242.4237.6.camel@gmail.com>
References: <1433991854.2170.47.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id C6BEF260425
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 16:04:07 +0200 (CEST)
Received: by pabvl15 with SMTP id vl15so16084108pab.1
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 07:04:06 -0700 (PDT)
Received: from [192.168.0.198] ([175.180.119.154])
 by mx.google.com with ESMTPSA id iv7sm8203218pbc.20.2015.06.18.07.04.05
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jun 2015 07:04:05 -0700 (PDT)
In-Reply-To: <1433991854.2170.47.camel@gmail.com>
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

Dear ALSA developers,

I am trying to get into ALSA development. I need some help.

I checked out to the head of the alsa-driver mirror branch (latest
update 9 days ago).

I made some changes to the usb/mixer_scarlett.c file. (just to test,
change the text of the output channels only for the 18i20)

Questions:

How can I build this?
How can I and update (Ubuntu 15.04) with this new build to this change?

Thank you very much!

Martin
