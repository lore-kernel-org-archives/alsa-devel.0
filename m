From: Alan Young <Alan.Young@IEE.org>
Subject: ALSA timestamping for kernel SoC drivers
Date: Tue, 31 May 2016 12:08:05 +0100
Message-ID: <574D7095.4000300@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D1723265363
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 13:08:07 +0200 (CEST)
Received: by mail-wm0-f45.google.com with SMTP id z87so102842824wmh.0
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 04:08:07 -0700 (PDT)
Received: from [192.168.11.11] (169.84.189.80.dyn.plus.net. [80.189.84.169])
 by smtp.googlemail.com with ESMTPSA id d5sm39286432wje.20.2016.05.31.04.08.05
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Tue, 31 May 2016 04:08:05 -0700 (PDT)
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
