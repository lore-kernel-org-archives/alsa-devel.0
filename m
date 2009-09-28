From: Pascal Terjan <pterjan@mandriva.com>
Subject: [PATCH 0/3] Add quirks for Vaio VGN
Date: Mon, 28 Sep 2009 11:43:10 +0200
Message-ID: <1254130993-8235-1-git-send-email-pterjan@mandriva.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here are some quirks for 3 Vaio VGN model reported on launchpad to need
model=vaio

Pascal Terjan (3):
  [ALSA] Add quirk for Sony Vaio VGN-SZ650N
  [ALSA] Add quirk for Sony Vaio VGN-AR51M
  [ALSA] Add quirk for Sony Vaio VGN-FZ15G

 sound/pci/hda/patch_sigmatel.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
