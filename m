From: Lucas Marshall <lmarshall@ilm.com>
Subject: 48kHz SPDIF out on X-Fi?
Date: Thu, 3 Dec 2009 16:02:39 -0800
Message-ID: <A4F8AADD974930428E396D31DA01A2A80D1ECC93@mailbox03.lucas.alllucas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.lucasfilm.com (mailhub03.lucasfilm.com [208.72.12.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D7981037E3
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 01:02:50 +0100 (CET)
Content-Class: urn:content-classes:message
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

Is it possible to get the optical SPDIF on an X-Fi Titanium to output at
48kHz instead of 96kHz? I've tried doing a rate convert in .asoundrc,
adding a rate to the hw plug in there, etc. but no matter what it's
still spewing 96kHz according to my test receiver.

 

We would like to do a SPDIF-to-AES conversion, and our video/audio
router won't take anything but 48kHz. :(

 

Thanks in advance for any suggestions!

 

--

Lucas Marshall

Systems Administrator // Media Systems

Lucasfilm

415-746-2861
