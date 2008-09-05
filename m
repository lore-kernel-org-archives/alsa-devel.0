From: Harald Radke <harryrat@postnuklear.de>
Subject: WM8750 mixer controls
Date: Fri, 5 Sep 2008 10:25:36 +0200
Message-ID: <200809051025.36354.harryrat@postnuklear.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id DEF302433E
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 10:25:38 +0200 (CEST)
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

Hi there!

I noticed that using "alsamixer" several controls that are connected to sound 
input (ALC) are listed in the "playback" tab as well as in "capture", as well 
as certain playback controls as "bass" "trebel" also can be found under 
"capture". However, changing those controls' values only seem to take effect in 
the "playback" tab.

I was wondering if this is intentional or unintentional done by the WM8750 
codec driver  or an alsamixer "feature".

Thx

Greez,

Harry
