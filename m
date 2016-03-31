From: Ricardo Biehl <rbpoficial@gmail.com>
Subject: Real-time audio over local network with good quality
Date: Thu, 31 Mar 2016 15:52:50 -0300
Message-ID: <CAAu8FsdLJfSNau-OYcvja4F6rhFmu9skZvR0DeM38dA_wN+BMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id BA90C2666D6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 20:53:09 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id p65so237475070wmp.1
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 11:53:09 -0700 (PDT)
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

Hello guys! I'm sorry if this mail is not part of the scope of this list :-(

I've come from the kernelnewbies mailing list with the same subject as
following ...

I'm working on a project which aims to be a microphone system that
will work over local network <https://github.com/ricardobiehl/ipmic>.
So I've found many difficulties in ALSA library and Linux Network.
Basically, I need help to make my software get low latency and high
quality audio :-) .

When I said "high quality audio" I'm referring to (1channel * 16bit
sample * 22050Hz) without noise. And "low latency" is about to 0.1
second or less.

Any contribution with the project is welcome!

Thank you a lot!

-- 
Ricardo Biehl Pasquali
