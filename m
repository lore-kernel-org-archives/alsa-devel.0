From: James Miller <jamesstewartmiller@gmail.com>
Subject: tascam us122l patch commit
Date: Sat, 5 Oct 2013 11:35:58 +0100
Message-ID: <CAKJvYZH+wcTDXw1tGSp5zMSt4Xo8Gs1ZROsD3D1=qdznF1PB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C27BD2602C6
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 12:35:59 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id cm18so1797232qab.1
 for <alsa-devel@alsa-project.org>; Sat, 05 Oct 2013 03:35:58 -0700 (PDT)
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

Hi, I have just attempted to install the 3.10.10 realtime kernel and I have
discovered that the patch l listed in the following webpage :

http://www.remastersys.com/forums/index.php?topic=3013.60

doesn't seem to have made it 'upstream' (I am not particularly familiar
with the terminology).

It's simple to do by hand but I can confirm that I have been using the
above patch (VM_IO) on 3.8.13 and 3.10.10 kernels with success - the tascam
us122L works fine.

Many thanks


-- 
James Stewart Miller Bsc(hons) Psych.
