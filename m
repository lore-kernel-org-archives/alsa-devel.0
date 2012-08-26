From: Aaron Fulkerson <aaronallenfulkerson@gmail.com>
Subject: Driver for HT|OMEGA eCLARO (C-Media 8788 ***PCIe***)
Date: Sun, 26 Aug 2012 15:53:43 -0700
Message-ID: <CAB5Lu93CJe-AcTUD4QOdKwn5BkmD=fGWuxDdGhcRZPisnHs+bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 01B27265E11
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 00:53:43 +0200 (CEST)
Received: by qadz3 with SMTP id z3so1576455qad.17
 for <alsa-devel@alsa-project.org>; Sun, 26 Aug 2012 15:53:43 -0700 (PDT)
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

Hello and nice to meet you all. This will be my first post if the previous
one did not work.

The problem is this: there is not a working driver for the HT|OMEGA eCLARO.
The card is based on the C-Media 8788 chip for which there is an existing
driver, however, due to the fact that the eCLARO is a PCIe-based card, the
driver doesn't function properly. What are the chances of a working driver
being written for this card?
