From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Can't set 88.2/96kHz samplerate with Hammerfall
Date: Thu, 04 Dec 2003 15:32:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprznunrgeq1sf88@mail.broadpark.no>
References: <Pine.LNX.4.58.0312041139490.458@autumn> <s5hsmk0ai7r.wl@alsa2.suse.de> <Pine.LNX.4.58.0312041424210.458@autumn>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312041424210.458@autumn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

Whenever I try to activate double speed (88.2/96kHz) mode with my RME=20
Hammerfall Lite (DIGI 9636), snd_pcm_hw_params fails with a 'Device or=20
resource busy' message. This is with the number of channels set to 10,=20
since the number of ADAT channels is halved. Is this a known defect of th=
e=20
Hammerfall driver?

Thanks

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
