From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: alsa + xine problem
Date: Fri, 07 Mar 2003 00:06:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E67D45F.7010306@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

anyone knows what this output means? It's from Xine:


audio_alsa_out: Audio Device name = 
iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2
audio_alsa_out: Number of channels = 2
ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for 
symbol _snd_pcm_hook_ctl_elems_install
ALSA lib pcm_hooks.c:527:(snd_pcm_hook_add_conf) symbol 
_snd_pcm_hook_ctl_elems_install is not defined inside (null)
xiTK received SIGSEGV signal, RIP.
Aborted


Pieter



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
