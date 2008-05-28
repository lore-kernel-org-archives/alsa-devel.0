From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: power save of snd_hda_intel
Date: Wed, 28 May 2008 18:39:42 +0530
Message-ID: <827ad74d0805280609p8420727gcf08dd557a52ae5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.185])
	by alsa0.perex.cz (Postfix) with ESMTP id BF55924636
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 15:09:44 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id k32so1594132rnd.21
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 06:09:43 -0700 (PDT)
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

I am trying to get a power_save option of snd_hda_intel working.
We are using latest ALSA build and ALC262 codec. when we start the player
and close it, we dont see any power savings. [ We see the power saving in
windows with the same ALC262 card]

Any idea what i could be doing wrong here?

-- 
-Harsha
