From: John Covici <covici@ccs.covici.com>
Subject: problems using via82xx with 2.5.69
Date: Tue, 27 May 2003 12:06:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3llwsfk75.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi.  I compiled alsa as all modules using the ones provided in the
2.5.69 tree, but it loaded them and even though I have an
asound.state file which I use with the 2.4.20 kernel and the 0.9.3c
drivers, alsactl came up with two no information on control ... (I
think 37 and 38) no such file or directory, and no sound came out at
all -- all the volumes seemed to be at 0, even though the
asound.state file said otherwise, but I couldn't get anything even
though I tried to raise them using amixer.

What is happening here?

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
