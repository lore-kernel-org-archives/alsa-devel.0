From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - hdspmixer 0/4] Beautification patches
Date: Thu,  3 Feb 2011 22:43:33 +0100
Message-ID: <1296769417-1320-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Here's a line of code beautification patches for hdspmixer. I broke them up
into smaller pieces to ease the review, though one may find four patches
for no added functionality a little bit excessive. If so, please feel
free simply commit them as a single commit.


Cheers

Adrian Knoth (4):
  hdspmixer: retab and reindent code.
  hdspmixer: Improve readability.
  hdspmixer: Beautification; Lower nesting depth
  hdspmixer: Break overlong line and don't plenken.

-- 
1.7.2.3
