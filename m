From: Alan Young <consult.awy@gmail.com>
Subject: ALSA timestamping for kernel SoC drivers
Date: Tue, 31 May 2016 12:38:09 +0100
Message-ID: <574D77A1.7090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F382655DB
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 13:38:11 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id n129so104012412wmn.1
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 04:38:11 -0700 (PDT)
Received: from [192.168.11.11] (169.84.189.80.dyn.plus.net. [80.189.84.169])
 by smtp.googlemail.com with ESMTPSA id az2sm39489919wjc.6.2016.05.31.04.38.09
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Tue, 31 May 2016 04:38:10 -0700 (PDT)
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

Hello,

I need to get accurate timestamping of the kind currently available for HDA into some Freescale (iMX) SoC drivers. Is there anyone already working in this area or is there anyone who would be prepared to discuss the design and implementation details?

Alan.
