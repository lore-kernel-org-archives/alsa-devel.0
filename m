From: "Mihaela Vitalariu" <admiralwolverine@gmail.com>
Subject: I/O possible
Date: Wed, 16 Jan 2008 16:25:51 +0200
Message-ID: <ef33e0240801160625l204859apd2ea17b6fb30331a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 88F8224402
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 15:25:51 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so294908fgb.44
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 06:25:51 -0800 (PST)
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

Hello everyone!

I am coding a Linux sound application using the PCM interface.
It plays fine but at unexpected intervals i sometimes get a SIGIO
directly in my program, which exits printing the message "I/O possible".
What can be happening?

Any help would be greatly appreciated.
Simbasaurus.
