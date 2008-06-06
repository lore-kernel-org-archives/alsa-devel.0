From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: 3779 segmentation fault rmmod snd-timer.ko
Date: Fri, 6 Jun 2008 16:38:07 +0530
Message-ID: <827ad74d0806060408n9e3eb45t30c65ede3e75caab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B97524359
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 13:08:08 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so226727and.80
	for <alsa-devel@alsa-project.org>; Fri, 06 Jun 2008 04:08:07 -0700 (PDT)
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
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
When i rmmod all snd modules along with my new driver. It gives the
following message when i rmmod snd-timer.ko

3779 segmentation fault rmmod snd-timer.ko...any clues as to what i am doing
in my driver that is causing this?

-- 
-Harsha
