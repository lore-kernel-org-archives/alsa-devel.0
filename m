From: Felipe Tonello <eu@felipetonello.com>
Subject: [RFC] Add DummyDevice property to UCM
Date: Mon, 9 Jun 2014 15:43:46 -0700
Message-ID: <CAGrhNMwZ=kMZuMTgaKKBERVqzfWmhpgX7pGc=zALjXN3c8_3vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
 [74.125.82.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BCB2265619
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 00:43:47 +0200 (CEST)
Received: by mail-we0-f174.google.com with SMTP id k48so6645033wev.33
 for <alsa-devel@alsa-project.org>; Mon, 09 Jun 2014 15:43:46 -0700 (PDT)
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

Hi,

I would like to see what you guys think about adding a DummyDevice
official property to a UCM device. This is very useful for users to
configure properly when, let's say, the PCM is a dummy device. It is a
common practice on embedded systems to have dummy PCMs.

BR

Felipe
