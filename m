From: Pierre van Heerden <cassiopea342@gmail.com>
Subject: Bug 0005086 - no audio on built-in speakers (intel-hda
	with codec alc272)
Date: Tue, 3 Aug 2010 15:49:35 +0200
Message-ID: <AANLkTi=PpoTBcgukoY6u00SGW4=xnkoiNGOun-a9cABs@mail.gmail.com>
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
To: alsa-devel@mailman.alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I was advised to e-mail and inform you of the problem with my audio, even
though I have submitted a
tracker<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5086>.
In short, no speaker_outs are being reported by the driver (intel-hda using
the realtek alc272 codec), even in the latest release, so on my laptop (LG
X130) I'm getting audio on the line-out jack but not on the built-in
speakers. I've tried all the model= module parameters for the alc272 codec,
none of them solved the problem.

Please let me know if I can be of any assistance in solving this problem or
if you need any further information from me.

Kind regards
Pierre van Heerden
