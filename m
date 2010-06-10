From: David Song <tingustar@gmail.com>
Subject: Speaker auto-mute doesn't work on ALC269
Date: Thu, 10 Jun 2010 21:36:07 +0800
Message-ID: <AANLkTinmfa0Cbp0xWk84SAHqy8g12rhqTySlpJ5zsSaB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
	[209.85.211.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 9980F103981
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jun 2010 15:36:10 +0200 (CEST)
Received: by ywh32 with SMTP id 32so6310863ywh.5
	for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2010 06:36:09 -0700 (PDT)
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

When a headphone is plugged, I can hear sound from both speaker and headphone.
This issue exists on ASUS EeePC S101 and EeePC 1005PE which both have ALC269.
I'm testing with the latest kernel. Any regression here?
