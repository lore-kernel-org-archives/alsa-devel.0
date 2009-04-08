From: Diptopal Basu <diptopal.basu@gmail.com>
Subject: Need help on porting ALSA to ARM application baseboard
Date: Wed, 8 Apr 2009 09:57:28 +0530
Message-ID: <bd97640b0904072127g7838b604l30168358c37d43ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id AC75B2453C
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 06:27:29 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 4so2282113yxp.2
	for <alsa-devel@alsa-project.org>; Tue, 07 Apr 2009 21:27:28 -0700 (PDT)
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

Hi All ,

   I am working on ARM 926EJ-S Application baseboard . The board has a
LM4549 codec connected through an AACI prime cell . I am running Linux
2.6.26.5 on this board and the requirement now is to have an ogg vorbis
player running on the board , I am planning to use ogg123 for the same
purpose , but it requires ALSA driver on the board . Do you have any
information as to how to port ALSA on this particular board .

Regards
Diptopal Basu
