From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH 0/6] ASoC: davinci-mcbsp: add binding for McBSP
Date: Wed,  6 Apr 2016 15:21:27 +0200
Message-ID: <1459948893-4206-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A5B265DAC
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 15:21:44 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id u206so45349081wme.1
 for <alsa-devel@alsa-project.org>; Wed, 06 Apr 2016 06:21:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Petr Kulhavy <petr@barix.com>, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

This series of patches adds devicetree support for the davinci McBSP audio
interface.
