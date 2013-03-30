From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: Re: Guide to USB debugging in Windows?
Date: Sat, 30 Mar 2013 22:19:08 +0530
Message-ID: <CANc+2y6ip-ujUhptSYujEjC+e6p5ofyV1q7HHgeo2Yz=10Tf4Q@mail.gmail.com>
References: <20130329153639.GA72429@cons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 4113F261635
 for <alsa-devel@alsa-project.org>; Sat, 30 Mar 2013 17:49:09 +0100 (CET)
Received: by mail-wi0-f177.google.com with SMTP id hm14so597273wib.16
 for <alsa-devel@alsa-project.org>; Sat, 30 Mar 2013 09:49:09 -0700 (PDT)
In-Reply-To: <20130329153639.GA72429@cons.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Cracauer <cracauer@cons.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Install WIn 7 in a VM (Linux host), attach the USB device to it (qemu,
Virtualbox, VMWare support this). You can snoop USB traffic using usbmon in
Linux. You can use wireshark for getting the data flowing in the device.

Hope this helps,
PrasannaKumar
