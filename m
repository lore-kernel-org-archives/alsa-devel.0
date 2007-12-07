From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Query regarding external alsa plugins
Date: Fri, 7 Dec 2007 15:50:57 +0530
Message-ID: <61445c750712070220s1185cea2qd4624affee80af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 120EB2446D
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 11:20:58 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1403701wag
	for <alsa-devel@alsa-project.org>; Fri, 07 Dec 2007 02:20:57 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I am writing an external IO type plugin for my board since my audio driver
is going to be a user space driver
i.e. no alsa kernel driver because of some technical reasons. My pluging
works okay and now I want to provide
a mixer control interface like volume control and playback path  selection
etc.

Is there anything like mixer plugin etc which can be intergrated with my
existing plugin? Can I get a test code
somewhere?

Regards,
Sandeep.
