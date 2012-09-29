From: George Stefan <stefan.george87@gmail.com>
Subject: imx28 pcm issues
Date: Sat, 29 Sep 2012 16:08:37 +0300
Message-ID: <CAACwSTLNxKM1G1b1XkrvNSbJsu2n6h6+AhBOCicQvZgHeVycqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E2C3F26159D
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 15:08:37 +0200 (CEST)
Received: by eekd49 with SMTP id d49so1483283eek.38
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 06:08:37 -0700 (PDT)
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

Hi!
I have an issues with a modem connected to the SAIF port of an imx28.
I have the following configuration running on the modem:
  -modem is slave(but still have to fix the clock at 256 khz)
