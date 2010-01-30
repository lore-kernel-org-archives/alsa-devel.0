From: Jani Frilander <j.frilander@gmail.com>
Subject: A driver for Zoom R16 (USB)?
Date: Sat, 30 Jan 2010 08:08:05 +0200
Message-ID: <e53c6f621001292208v3a813be8v3c3875d43aa885e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D4BD103907
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 07:08:06 +0100 (CET)
Received: by ewy23 with SMTP id 23so96781ewy.4
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 22:08:06 -0800 (PST)
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

Hi.

I have a Zoom R16 multitrack recorder / USB audio interface / control
surface unit.
Unfortunately it's audio interface/control surface part currently don't work
with linux.
When I plug it in kernel (2.6.31-9-rt) won't recognize it as a audio
interface.

Is there a way to make it work? It probably needs to be hacked, because Zoom
won't
provide any technical information, according to their email I received.

I'm a total newbie in driver development, but I'll be willing to work with
this.

Regards,
Jani Frilander
