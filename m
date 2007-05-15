From: "Norman Schleicher" <NormanSchleicher@gmx.de>
Subject: Steinberg Midex 8 driver development
Date: Tue, 15 May 2007 11:35:57 +0200
Message-ID: <20070515093557.311300@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 56B7924346
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 11:35:58 +0200 (CEST)
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

I am currently on development for the Steinberg Midex8 USB driver.

At the moment I can send notes to my Midi equipment via this device. Receiving is currently not implemented.

My questions are:
1. Are there any tools to test the Alsa-Midi compatiblity ?
2. May I release some milestone results to the Alsa project ? Eg when the driver supports a small subset of send commands supported by midi.
3. What are the requirements to get released in an official alsa release package ?
4. Who is responsible for the version management ? Where can I read how the source code is organized in the repository and how to manage tags and branches for the development ?(I don't need an introduction how to use CVS, thats clear for me.)

Regards Norman
